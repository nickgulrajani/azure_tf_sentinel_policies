# Configure the Azure provider

provider "azure" {
  version = ">= 2.0.0"
}

# Define the policy sets and their associated policies
policy_sets = [
  {
    name    = "azure_cost_policy"
    enforce = true
    policies = ["main"]
  }
]

# Define the policy declarations
main = sentinel {

  import "azure/cost-analysis"


  # Define the allowed monthly cost threshold
  allowed_monthly_cost = 100

  # Define the policy
  rule {
    all azure.cost-analysis.resource_groups as rg {
      cost := azure.cost-analysis.cost_per_month(rg)
      cost < allowed_monthly_cost
    }
  }
}



