import os
import subprocess

URL = 'myorg.com'
GIT_TOKEN = 'your_token_here'

# Ensure the environment variables are set
os.environ['GIT_ASKPASS'] = os.path.join(os.path.dirname(__file__), 'git_askpass.py')
os.environ['GIT_TOKEN'] = GIT_TOKEN

try:
    # Replace this with your actual code to fetch repository endpoints
    repos = [{'repoURL': 'https://github.com/myorg/repo1.git'}, {'repoURL': 'https://github.com/myorg/repo2.git'}]  
    
    for repo in repos:
        REPO = repo['repoURL']
        subprocess.run(['git', 'clone', REPO], check=True)
except Exception as err:
    print('error:', err)