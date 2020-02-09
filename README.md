# sandbox

## git hooks
- **commit-msg** (first line of commit message: RegEx: https://regexr.com/4tte7)
- **pre-push** (branch name: RegEx: https://regexr.com/4ttd6)

To auto-enable the hooks within this project, run `composer install`

To activate the hooks in any other git-project (if you have custom hooks, they will be overwritten!) run:

```
cd <your git-project>
```

**commit-msg:**

```
touch .git/hooks/commit-msg
chmod 755 .git/hooks/commit-msg
tee .git/hooks/commit-msg << 'END'
#!/usr/bin/env bash
COMMIT_MSG=$1
FIRST_LINE=`head -n1 $COMMIT_MSG`
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
PATTERN="^\[((FEATURE|BUGFIX|HOTFIX|TASK|FOLLOWUP) #[0-9]+|(TASK))\] [A-Z].{6,}$"
if ! [[ "$FIRST_LINE" =~ $PATTERN ]]; then
  printf "${RED}!§\$&#*\?\$§! Bad boy!!! Bad commit message \'${FIRST_LINE}\'! Your commit will be rejected!\n"
  printf "${NC}Use our pattern: ${YELLOW}${PATTERN}\n"
  printf "${NC}Good example: ${YELLOW}'[FEATURE #123456] Implement this fancy stuff'.\n"
  printf "${NC}Allowed keywords are: ${YELLOW}FEATURE, BUGFIX, HOTFIX, FOLLOWUP, TASK\n"
  printf "${NC}Minimal length: 7 chars, first char = capital letter\n"
  exit 1
fi
END
```

**pre-push:**

```
touch .git/hooks/pre-push
chmod 755 .git/hooks/pre-push
tee .git/hooks/pre-push << 'END'
#!/usr/bin/env bash
LOCAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
PATTERN="^(release)\/(\d+\.){1,2}\d+?$|^(master|development|staging|production)$|^jira-\d+\/[a-z0-9-]+$"
if ! [[ "$LOCAL_BRANCH" =~ $PATTERN ]]; then
    printf "${RED}!§\$&#*\?\$§! Bad boy!!! Bad branch name \'${LOCAL_BRANCH}\'! Your commit will be rejected!\n"
    printf "${NC}Use our pattern: ${YELLOW}${PATTERN}\n"
    exit 1
fi
END
```
