# Opsera Terraform Multi-Environment Pipeline Testing

Simple mono repo structure for testing Opsera folder-based pipeline triggers.

## Repository Structure

```
.
├── dev/                    # Development environment
│   └── main.tf
├── qa/                     # QA environment
│   └── main.tf
├── prod/                   # Production environment
│   └── main.tf
├── common/                 # Common/shared resources
│   └── main.tf
├── modules/                # Shared Terraform modules
│   └── sample_module/
│       └── main.tf
└── opsera/                 # Opsera pipeline configurations
```

## Pipeline Trigger Logic

| Pipeline | Triggers On |
|----------|-------------|
| **dev**  | Changes to `/dev/**` or `/modules/**` |
| **qa**   | Changes to `/qa/**` or `/modules/**` |
| **prod** | Changes to `/prod/**` or `/modules/**` |
| **common** | Changes to `/common/**` or `/modules/**` |

## Testing Locally

Each environment can be tested with:

```bash
cd dev
terraform init
terraform plan
terraform apply
```

This will output simple messages without creating any infrastructure.

## Use Case

This structure enables:
1. **Four independent pipelines** (dev, qa, prod, common) per Snowflake account
2. **Folder-based triggers** - each pipeline triggers only on relevant folder changes
3. **Shared modules** - changes to `/modules/**` can trigger all environment pipelines
4. **Separate state files** - each environment manages its own state

## Opsera Configuration

Configure Opsera to:
1. Monitor the main branch for changes
2. Filter webhook events by changed file paths
3. Trigger only the relevant environment pipeline(s)

See `opsera/` folder for pipeline configuration examples.

## Deadline

Implementation approach and timeline needed by: **Friday, Feb 13, 2026**
