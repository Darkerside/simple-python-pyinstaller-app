pipeline {
    agent {
        docker {
            image 'python:3.7-alpine3.17'
            args '-p 5000:5000'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Compile') {
            agent {
                docker {
                    image 'python:3.7-alpine3.17'
                }
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'python -m py_compile sources/add2vals.py sources/calc.py'
                    stash(name: 'compiled-results', includes: 'sources/*.py*')
                }
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'python:3.7-alpine3.17'
                }
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'pip3 install Flask'
                    sh 'pip3 install pytest'
                    sh 'python -m pytest --junit-xml test-reports/results.xml sources/test_calc.py' 
                    sh 'python -m pytest sources/test_api.py'
                }
            }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }
        stage('Deploy') {
            agent any
            steps {
                input message: 'Yakin untuk deploy App ke production?'
                // sshagent (credentials: ['ec2jenkins']) {
                //     sh 'chmod +x -R ./jenkins/scripts/deploy.sh'
                // }
                // withEnv(["HOME=${env.WORKSPACE}"]) {
                //     sh 'chmod +x -R ./jenkins/scripts/kill.sh'
                //     sh './jenkins/scripts/kill.sh'
                // }
            }
        }
    }
}
