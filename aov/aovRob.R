aovRob <- function (formula, data = NULL, projections = FALSE, qr = TRUE, 
    contrasts = NULL, ...) 
{
    Terms <- if (missing(data)) 
        terms(formula, "Error")
    else terms(formula, "Error", data = data)
    indError <- attr(Terms, "specials")$Error
    if (length(indError) > 1L) 
        stop(sprintf(ngettext(length(indError), "there are %d Error terms: only 1 is allowed", 
            "there are %d Error terms: only 1 is allowed"), length(indError)), 
            domain = NA)
    lmcall <- Call <- match.call()
    lmcall[[1L]] <- quote(stats::lm)
    lmcall$singular.ok <- TRUE
    if (projections) 
        qr <- lmcall$qr <- TRUE
    lmcall$projections <- NULL
    if (is.null(indError)) {
        fit <- eval(lmcall, parent.frame())
        if (projections) 
            fit$projections <- proj(fit)
        class(fit) <- if (inherits(fit, "mlm")) 
            c("maov", "aov", oldClass(fit))
        else c("aov", oldClass(fit))
        fit$call <- Call
        return(fit)
    }
    else {
        if (pmatch("weights", names(match.call()), 0L)) 
            stop("weights are not supported in a multistratum aov() fit")
        opcons <- options("contrasts")
        options(contrasts = c("contr.helmert", "contr.poly"))
        on.exit(options(opcons))
        allTerms <- Terms
        errorterm <- attr(Terms, "variables")[[1 + indError]]
        eTerm <- deparse(errorterm[[2L]], width.cutoff = 500L, 
            backtick = TRUE)
        intercept <- attr(Terms, "intercept")
        ecall <- lmcall
        ecall$formula <- as.formula(paste(deparse(formula[[2L]], 
            width.cutoff = 500L, backtick = TRUE), "~", eTerm, 
            if (!intercept) 
                "- 1"), env = environment(formula))
        ecall$method <- "qr"
        ecall$qr <- TRUE
        ecall$contrasts <- NULL
        er.fit <- eval(ecall, parent.frame())
        options(opcons)
        nmstrata <- attr(terms(er.fit), "term.labels")
        nmstrata <- sub("^`(.*)`$", "\\1", nmstrata)
        nmstrata <- c("(Intercept)", nmstrata)
        qr.e <- er.fit$qr
        rank.e <- er.fit$rank
        if (rank.e < NROW(er.fit$coefficients)) 
            warning("Error() model is singular")
        qty <- er.fit$residuals
        maov <- is.matrix(qty)
        asgn.e <- er.fit$assign[qr.e$pivot[1L:rank.e]]
        maxasgn <- length(nmstrata) - 1L
        nobs <- NROW(qty)
        len <- if (nobs > rank.e) {
            asgn.e[(rank.e + 1):nobs] <- maxasgn + 1L
            nmstrata <- c(nmstrata, "Within")
            maxasgn + 2L
        }
        else maxasgn + 1L
        result <- setNames(vector("list", len), nmstrata)
        lmcall$formula <- form <- update(formula, paste(". ~ .-", 
            deparse(errorterm, width.cutoff = 500L, backtick = TRUE)))
        Terms <- terms(form)
        lmcall$method <- "model.frame"
        mf <- eval(lmcall, parent.frame())
        xlev <- .getXlevels(Terms, mf)
        resp <- model.response(mf)
        qtx <- model.matrix(Terms, mf, contrasts)
        cons <- attr(qtx, "contrasts")
        dnx <- colnames(qtx)
        asgn.t <- attr(qtx, "assign")
        if (length(wts <- model.weights(mf))) {
            wts <- sqrt(wts)
            resp <- resp * wts
            qtx <- qtx * wts
        }
        qty <- as.matrix(qr.qty(qr.e, resp))
        if ((nc <- ncol(qty)) > 1L) {
            dny <- colnames(resp)
            if (is.null(dny)) 
                dny <- paste0("Y", 1L:nc)
            dimnames(qty) <- list(seq(nrow(qty)), dny)
        }
        else dimnames(qty) <- list(seq(nrow(qty)), NULL)
        qtx <- qr.qty(qr.e, qtx)
        dimnames(qtx) <- list(seq(nrow(qtx)), dnx)
        for (i in seq_along(nmstrata)) {
            select <- asgn.e == (i - 1L)
            ni <- sum(select)
            if (!ni) 
                next
            xi <- qtx[select, , drop = FALSE]
            cols <- colSums(xi^2) > 1e-05
            if (any(cols)) {
                xi <- xi[, cols, drop = FALSE]
                attr(xi, "assign") <- asgn.t[cols]
                fiti <- lm.fit(xi, qty[select, , drop = FALSE])
                fiti$terms <- Terms
            }
            else {
                y <- qty[select, , drop = FALSE]
                fiti <- list(coefficients = numeric(), residuals = y, 
                  fitted.values = 0 * y, weights = wts, rank = 0L, 
                  df.residual = NROW(y))
            }
            if (projections) 
                fiti$projections <- proj(fiti)
            class(fiti) <- c(if (maov) "maov", "aov", oldClass(er.fit))
            result[[i]] <- fiti
        }
        result <- result[!sapply(result, is.null)]
        class(result) <- c("aovlist", "listof")
        if (qr) 
            attr(result, "error.qr") <- qr.e
        attr(result, "call") <- Call
        if (length(wts)) 
            attr(result, "weights") <- wts
        attr(result, "terms") <- allTerms
        attr(result, "contrasts") <- cons
        attr(result, "xlevels") <- xlev
        result
    }
}
