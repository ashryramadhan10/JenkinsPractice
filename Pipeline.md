# Pipeline

[https://www.jenkins.io/doc/book/pipeline/jenkinsfile/](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/)

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

It's just a file named `Jenkinsfile` with jenkins pipeline inside of it.

## 4. Agent

```groovy
pipeline {
    agent {
        node {
            label "jenkins_agent1"
        }
    }
    stages {
        stage("hello") {
            steps {
                echo("Hello Pipeline with jenkins_agent1")
            }
        }
    }
}
```

## 5. Post

```groovy
pipeline {
    agent {
        node {
            label "jenkins_agent1"
        }
    }
    stages {
        stage("hello") {
            steps {
                echo("Hello Pipeline with jenkins_agent1")
            }
        }
    }

    post {
        always {
            echo "always be executed"
        }
        changed {
            echo "condition changed will be executed"
        }
        fixed {
            echo "will be executed if error resolve"
        }
        regression {
            echo "will be executed if from success to error"
        }
        aborted {
            echo "will be executed if the pipeline is aborted manually"
        }
        failure {
            echo "if status pipeline error"
        }
        success {
            echo "if status pipeline success"
        }
        cleanup {
            echo "always be executed after previous post"
        }
    }
}
```

## 6. Stages

Tips: Install Jenkins Plugin `Stages View`

```groovy
stages {
    stage("Build") {
        steps {
            echo("Build Stage")
        }
    }
    stage("Test") {
        steps {
            echo("Test Stage")
        }
    }
    stage("Deploy") {
        steps {
            echo("Deploy Stage")
        }
    }
}
```

## 7. Steps

### 7.1. Basic Steps

[https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/](https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/)

Example:

```groovy
steps {
    echo 'Sleeping for 5 seconds'
    sleep(5)
}
```

### 7.2. Nodes and Process Steps

[https://www.jenkins.io/doc/pipeline/steps/workflow-durable-task-step/](https://www.jenkins.io/doc/pipeline/steps/workflow-durable-task-step/)

We will try to use one of the steps: `sh`.

```groovy
steps {
    sh "echo $HOME"
}
```

### 7.3. Script

`Script` is used for a complex pipeline. It use groovy language. [https://groovy-lang.org/](https://groovy-lang.org/)

```groovy
stages {
    stage("Build") {
        steps {
            echo "Start Looping:"
            script {
                for (int i = 0; i <10; i++) {
                    echo "Script ${i}"
                }
            }
        }
    }
}
```

```groovy
script {
    sh 'make'
    archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true 
}
```

### 7.4. Utility Step

[https://www.jenkins.io/doc/pipeline/steps/pipeline-utility-steps/](https://www.jenkins.io/doc/pipeline/steps/pipeline-utility-steps/)

```groovy
script {
    def data = [
        "firstName": "Ashry",
        "lastName": "Ramadhan"
    ]
    writeJSON(file: "data.json", json: data)
}
```

### 7.5. Other Steps

You can check all of the steps here:
[https://www.jenkins.io/doc/pipeline/steps/](https://www.jenkins.io/doc/pipeline/steps/)

## 8. Agent Per Stage

In case of we need a different agents for each stage. We need to set `agent` to `none`.

```Groovy
pipeline {
    agent none
    stages {
        stage("Build") {
            agent {
                node {
                    label "jenkins_agent1"
                }
            }
        }
    }
}
```

## 9. Global Variable

Go to `Job` > `Pipeline Syntax` > `Global Variables Referece`

### 9.1. Env Varibale

`env` variable is a variable that we can use to get the Global Variable.

`currentBuild` can be used for getting information regarding the current process build.

```groovy
steps {
    echo "Start Job: ${env.JOB_NAME}"
    echo "Start Build: ${env.BUILD_NUMBER}"
    echo "Branch Name: ${env.BRANCH_NAME}"
}
```

## 10. Environment

* Pipeline has a feautre to add `environment` variable
* If we add it below `pipeline` then all of the stages can access it.
* If we add it below a `stage`, then only that stage can access it.

```groovy
pipeline {
    ...
    environment {
        AUTHOR_NAME = "Ashry Ramadhan"
    }

    stages {
        stage("Build") {
            environment {
                STAGE_NAME = "Build"
            }
            echo "Author: ${AUTHOR_NAME}"
            echo "STAGE_NAME: ${STAGE_NAME"}
        }
        ...
    }
    ...
}
```

## 11. Credentials

* `credentials` keyword is used to get the credentials from Jenkins Credentials. 
* This way is more secure rathen than we write it manually in the Jenkinsfile.
* Not all of the credentials is supported.

### 11.1. Credential Types

* Secret Text: `value of secret text`
* Secret File: `path`
* Username and Password: environment variable of `USER_NAME` and `USER_PASSWORD`
* SSH with private key: `path` and `environment variable`

```groovy
environment {
    // APP = credentials("<ID>")
    APP = credentials("ashry-ramadhan")
}

// Unsafety way
echo "${APP_USR}:${APP_PSW}" // use "

// Safety way
sh('echo "$APP_PSW"') // use '
```

## 12. Options

[https://www.jenkins.io/doc/book/pipeline/syntax/#options](https://www.jenkins.io/doc/book/pipeline/syntax/#options)

* `Option` can be placed below `pipeline` or `stage`

```groovy
pipline {
    options {
        disableConcurrentBuilds()
        timeout(time: 60, unit: 'SECONDS')
    }
}
```

## 13. Parameter

This is a `Job`'s parameter, the same one on the basic Jenkins.

```groovy
pipeline {
    agent none
    environment {
        AUTHOR = "Ashry Ramadhan"
    }
    parameters {
        string(name: 'NAME', defaultValue: 'Gues', description: 'What is your name?')
        text(name: 'DESCRIPTION', defaultValue: '', description: 'Tell me about you')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Need to deploy?')
        choice(name: 'SOCIAL_MEDIA', choices: ['Instagram', 'Facebook', 'Twitter'], description: 'Which social media?')
        password(name: 'SECRET', defaultValue: '', description: 'Ecrypt Key')
    }
    stages {
        stage("Parameter") {
            agent {
                node {
                    label "jenkins_agent1"
                }
            }
            steps {
                echo "Hello ${params.NAME}"
                echo "Description: ${params.DESCRIPTION}"
                echo "Deploy: ${params.DEPLOY}"
                echo "Social Media: ${params.SOCIAL_MEDIA}"
                echo "Secret: ${params.SECRET}"
            }
        }
    }
}
```

## 14. Triggers

`Triggers` is used for to trigger the `Job` Automatically.

Trigger Types:
* `cron`: will run the `Job` periodically
* `pollSCM` using cron expression to automatically running the `Job` if any changes happens.
* `upstream` is used for running a `Job` after another `Job` is finish. [https://javadoc.jenkins-ci.org/hudson/model/Result.html](https://javadoc.jenkins-ci.org/hudson/model/Result.html)

The one that will be commonly used is `Poll SCM`, it will polling the git repository based on the `cron` syntax.

```groovy
pipeline {
    agent none
    environment {
        ...
    }
    parameters {
        ...
    }
    options {
        ...
    }
    triggers {
        cron("*/5 * * * *") // every 5 minutes
        pollSCM("*/15 * * *") // every 5 minutes
        upstream(upstreamProjects: 'job1,job2', threshold: hudson.model.Result.SUCCESS)
    }
}
```

:warning: Note: you need to Build it first to get the update of the Build Triggers.

## 15. Input

* `Input` similar with `parameters`
* `Input` can be used as an order that can be added to the stage
* If we are adding the `input` to the stage, the stage will not running untill fill the `input` in.

### 15.1. Input Option

* `Input` can work similar with `option` as well
* `ID` is an identifier for input, the default same with the stage name
* `Ok` text for ok button
* `Submitter` is the user that allowed to filling the input, can use `coma` if the user is more than one
* `parameters` is the parameters that the user need to input

```groovy
pipeline {
    ...
    stages {
        stage("Build") {
            agent {
                node {
                    label "jenkins_agent1"
                }
            }
            input {
                message "Should we deploy?"
                ok "Yes, of course"
                submitter "ashryramadhan"
            }
            steps {
                echo "Deploy to ${TARGET_ENV}"
            }
        }
    }
}
```

## 16. When

`When` is used to determine when the stage will be executed (conditional expression). [https://www.jenkins.io/doc/book/pipeline/syntax/#when](https://www.jenkins.io/doc/book/pipeline/syntax/#when)

```groovy
pipeline {
    ...
    parameters {
        ...
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Need to deploy?')
    }
    stages {
        stage("Release") {
            when {
                expression {
                    return params.DEPLOY
                }
            }
            agent {
                node {
                    label ..
                }
            }
            steps {
                
            }
        }
    }
}
```

## 17. Sequential Stages

* Stages could have more than one stage.
* By default it will be executed `sequentially`.
* We can include `stages` inside `stage`
```groovy
stages {
    stage("Preparation") {
        agent {
            ...
        }
        stages {
            stage("Preparation Java") {
                steps {
                    echo "Prepare Java"
                }
            }

            stage("Prepare Maven") {
                steps {
                    echo "Prepare Maven"
                }
            }
        }
    }
}
```

## 18. Parallel Stages

* Sometimes, we want our stages run in parallel
* By default parallel will wait all of process/threads to join together, even one of them has error
* However, if we want to stop all of the stage process while we have an error in one of our stage, then we could add `failFast` or `parallelAlwaysFailFast()` in options
* :warning: When we are using parallel we can't set an agent at the top of the stage, therefore, we need to specified all of agents at each stage.

```groovy
stages {
    stage("Preparation") {
        failFast true
        parallel {
            stage("Prepare Java") {
                agent {
                    node {
                        label "jenkins_agent_java"
                    }
                }
                steps {
                    echo "Prepare Java"
                    sleep(5)
                }
            }
            stage("Prepare Maven") {
                agent {
                    node {
                        label "jenkins_agent_maven"
                    }
                }
                steps {
                    echo "Prepare Maven"
                    sleep(5)
                }
            }
        }
    }
}
```

## 19. Matrix

* Matrix is a feature that we can use to define multi dimension matrix which contains a combination of name-value, and it will run in parallel
* Matrix is `super powerfull` because it will run all of stages in parallel using the matrix's combination, We put stages below the `axes`
* `failFast` and `parallelAlwaysFailFast()` will work on Matrix as well

```groovy
stages {
    stage("OS Setup") {
        matrix {
            axes {
                axis {
                    name 'OS'
                    values 'linux', 'windows', 'mac'
                }
                axis {
                    name 'ARC'
                    values '32', '64'
                }
            }
            // based on the Matrix Cell, if we use the Matrix's variable
            // it will generate the combination of it
            stages {
                stage("OS Setup") {
                    agent {
                        node {
                            label "linux && java11"
                        }
                    }
                    steps {
                        echo "Setup ${OS} ${ARC}"
                    }
                }
            }
        }
    }
}
```

### 19.1. Exclude Matrix Cell

If we want to exlude our Matrix Cell we can use Exclude

```groovy
stages {
    stage("OS Setup") {
        matrix {
            axes {
                axis {
                    name 'OS'
                    values 'linux', 'windows', 'mac'
                }
                axis {
                    name 'ARC'
                    values '32', '64'
                }
            }
            // If you want to Exclude the matrix cell
            excludes {
                exclude {
                    axis {
                        name "OS"
                        values "mac"
                    }
                    axis {
                        name "ARC"
                        values "32"
                    }
                }
            }
            // based on the Matrix Cell, if we use the Matrix's variable
            // it will generate the combination of it
            stages {
                stage("OS Setup") {
                    agent {
                        node {
                            label "linux && java11"
                        }
                    }
                    steps {
                        echo "Setup ${OS} ${ARC}"
                    }
                }
            }
        }
    }
}
```

## 20. Credentials Binding

If we don't want to expose the credentials using `withCredentials` and want to use credentials at some parts at our pipeline then we can use this plugin. [https://www.jenkins.io/doc/pipeline/steps/credentials-binding/](https://www.jenkins.io/doc/pipeline/steps/credentials-binding/)

Search for plugin `Credentials Binding Plugin`

`$USER` and `$PASSWORD` can only be accessed inside the `withCredentials`

```groovy
steps {
    withCredentials([usernamePassword(
        credentialsId: "ashry-ramadhan",
        usernameVariable: "USER",
        passwordVariable: "PASSWORD"
    )]) {
        sh('echo "Release with -u $USER -p $PASSWORD"')
    }
}
```

## 21. Multibranch Pipeline

* Go to `New Item` > `Multibranch Pipeline`
* Configure your `Job` with your `Git`
* On `Build Configuration` choose `Jenkinsfile`
* Set `Scan Multibranch Pipeline Triggers`
* Add new branches `git checkout -b develop`
* Click `Scan Multibranch Pipeline Now`

## 22. Pipeline Limitation

* We can only just create a not really long Jenkins Pipeline.








