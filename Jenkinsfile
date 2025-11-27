pipeline {
    agent any
triggers {
    pollSCM('* * * * *')   // runs on every push (or use webhook)
}
    stages {
        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ahmedredaooooo/DEPI-DEVOPS-PROJECT-2'
            }
        }

        stage('Rebuild & Restart Containers') {
            steps {
                sh '''
                    docker compose down
                    docker compose build --no-cache
                    docker compose up -d
                '''
            }
        }
    }
}
