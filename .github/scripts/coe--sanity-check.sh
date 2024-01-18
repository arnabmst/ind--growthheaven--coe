# Scans the code and displays it as a table
git config --global --add safe.directory '*'

export HOME=/root

sfdx scanner:run --format table --target "force-app/main" --normalize-severity -c "Security,Best Practices,Performance,Code Style,Design,Error Prone,ECMAScript 6,Possible Errors,Variables,Stylistic Issues"