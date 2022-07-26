# infracost test

When using the task definition from a module, the reference to the family gets lost even though the `family` is a valid input for `ecs_service.task_definition`.

```sh
infracost-test % infracost breakdown --path . --show-skipped        
Evaluating Terraform directory at .
  ✔ Downloading Terraform modules 
  ✔ Evaluating Terraform directory 
  ✔ Retrieving cloud prices to calculate costs 

Project: github.com/anitakrueger/infracost-test.git

 Name                     Monthly Qty  Unit  Monthly Cost 
                                                          
 aws_ecs_service.service                                  
 ├─ Per GB per hour               0.5  GB           $1.62 
 └─ Per vCPU per hour            0.25  CPU          $7.39 
                                                          
 OVERALL TOTAL                                      $9.01 
──────────────────────────────────
4 cloud resources were detected:
∙ 2 were estimated
∙ 2 were free:
  ∙ 1 x aws_ecs_cluster
  ∙ 1 x aws_ecs_task_definition
```