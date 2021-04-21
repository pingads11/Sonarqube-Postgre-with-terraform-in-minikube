resource "helm_release" "sonarqube" {
  name  = "sonarqube"
  chart = "stable/sonarqube"

  set {
    name  = "persistence.enabled"
    value = "true"
  }
  set {
    name  = "readinessProbe.sonarWebContext"
    value = "/sonarqube/"
  }
  set {
    name  = "livenessProbe.sonarWebContext"
    value = "/sonarqube/"
  }
  set {
    name  = "replicaCount"
    value = "3"
  }
  set {
    name  = "image.tag"
    value = "7.8-community"
  }
  set {
    name  = "postgresql.enabled"
    value = "false"
  }
  set {
    name  = "database.type"
    value = "postgresql"
  }
  set {
    name  = "postgresql.postgresqlServer"
    value = "sonarqubedatabase-postgresql"
  }
  set {
    name  = "postgresql.postgresqlUsername"
    value = "postgreuser"
  }
  set {
    name  = "postgresql.postgresqlPassword"
    value = "postgrepass"
  }
  set {
    name  = "postgresql.postgresqlDatabase"
    value = "postgresonarqubedb"
  }
}
