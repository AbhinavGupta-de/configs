

# Added by Toolbox App
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"


# Setting PATH for Python 3.13
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH

# --- PostgreSQL 16.10 (Homebrew) Environment Setup ---
export PGHOME="/opt/homebrew/opt/postgresql@16"
export PGDATA="/opt/homebrew/var/postgres"
export PGLOG="$PGDATA/server.log"
export PGUSER="$USER"
export PGDATABASE="postgres"
export PGPORT="5432"

# Add PostgreSQL binaries to PATH
export PATH="$PATH:$PGHOME/bin"

# Helpful aliases
alias pgstart="brew services start postgresql@16"
alias pgstop="brew services stop postgresql@16"
alias pgrestart="brew services restart postgresql@16"
alias pgstatus="brew services list | grep postgresql@16"
alias psql16="psql -U $PGUSER -d $PGDATABASE -p $PGPORT"
