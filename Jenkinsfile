pipeline {
    agent any
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
        stage('Generate Exec') {
            agent any
            environment { 
                VOLUME = '$(pwd)/sources:/src'
                IMAGE = 'cdrx/pyinstaller-linux:python3'
            }
            steps {
                dir(path: 'build') { 
                    unstash(name: 'compiled-results') 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'pyinstaller -F add2vals.py'" 
                }
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'ls'
                }
            }
            post {
                success {
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
                }
            }
        }
        stage('Manual Approval') {
            agent any
            steps {
                input message: 'Lanjutkan ke tahap Deploy??'
            }
        }
        stage('Deploy') {
            agent any
            steps {
                sshagent (credentials: ['ec2jenkins']) {
                    sh 'chmod +x -R ./jenkins/scripts/deploy.sh'
                    sh './jenkins/scripts/deploy.sh'
                }
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'chmod +x -R ./jenkins/scripts/kill.sh'
                    sh './jenkins/scripts/kill.sh'
                }
            }
        }
    }
}
