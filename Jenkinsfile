pipeline {
    agent none
    environment {
        AUTHOR_NAME = "Ashry Ramadhan"
        APP = credentials("ashry-ramadhan")
    }
    parameters {
        string(name: 'NAME', defaultValue: 'Gues', description: 'What is your name?')
        text(name: 'DESCRIPTION', defaultValue: '', description: 'Tell me about you')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Need to deploy?')
        choice(name: 'SOCIAL_MEDIA', choices: ['Instagram', 'Facebook', 'Twitter'], description: 'Which social media?')
        password(name: 'SECRET', defaultValue: '', description: 'Ecrypt Key')
    }
    stages {
        stage("Build") {
            agent {
                node {
                    label "jenkins_agent1"
                }
            }
            steps {
                echo "Build Stage, Sleep for 5 seconds"
                // sleep(5)
                sh 'echo $HOME'

                echo "Start Looping:"
                // script {
                //     for (int i = 0; i <10; i++) {
                //         echo "Script ${i}"
                //     }
                // }

                // script {
                //     def data = [
                //         "firstName": "Ashry",
                //         "lastName": "Ramadhan"
                //     ]
                //     writeJSON(file: "data.json", json: data)
                // }
            }
        }
        stage("Test") {
            agent {
                node {
                    label "jenkins_agent1"
                }
            }
            environment {
                STAGE_NAME = "TEST"
            }
            steps {
                echo "stage name: ${STAGE_NAME}" 
                echo "author name: ${AUTHOR_NAME}"
                sh('echo "$APP_USR:$APP_PSW"')

                // script {
                //     sh 'touch test.txt'
                //     archiveArtifacts artifacts: '*.txt', fingerprint: true
                // }

                echo "Hello ${params.NAME}"
                echo "Description: ${params.DESCRIPTION}"
                echo "Deploy: ${params.DEPLOY}"
                echo "Social Media: ${params.SOCIAL_MEDIA}"
                echo "Secret: ${params.SECRET}"
            }
        }
        stage("Deploy") {
            agent {
                node {
                    label "jenkins_agent1"
                }
            }
            steps {
                echo "Deploy Stage"
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