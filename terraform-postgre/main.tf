resource "helm_release" "sonarqubedatabase" {
  name  = "sonarqubedatabase"
  chart = "stable/postgresql"

  set {
    name  = "postgresqlPassword"
    value = "postgrerootpass"
  }

  set {
    name  = "postgresqlUsername"
    value = "postgreuser"
  }
  set {
    name  = "postgresqlPassword"
    value = "postgrepass"
  }
  set {
    name  = "postgresqlDatabase"
    value = "postgresonarqubedb"
  }
}
