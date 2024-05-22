# Pipeline

## 1. Install Pipeline Plugin

Go to `Manage Jenkins` > `Manage Plugins` > Seach for `Pipeline`

## 2. Pipeline Basic Scripts

Go to `New Item` > Choose `Pipeline` > Fill below script on `Pipeline`:

```groovy
pipeline {
    agent any
    stages {
        stage("hello") {
            steps {
                echo("Hello Pipeline")
            }
        }
    }
}
```

## 3. Jenkinsfile

