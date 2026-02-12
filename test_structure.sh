#!/bin/bash

echo "=========================================="
echo "Testing Terraform Mono Repo Structure"
echo "=========================================="
echo ""

# Test each environment
for env in dev qa prod common; do
    echo "Testing $env environment..."
    if [ -f "$env/main.tf" ]; then
        echo "✓ $env/main.tf exists"

        # Check if it references the module
        if grep -q "source = \"../modules/sample_module\"" "$env/main.tf"; then
            echo "✓ $env uses shared module"
        fi

        # Check if it has outputs
        if grep -q "output" "$env/main.tf"; then
            echo "✓ $env has output definitions"
        fi
    else
        echo "✗ $env/main.tf missing"
    fi
    echo ""
done

# Test module
echo "Testing shared module..."
if [ -f "modules/sample_module/main.tf" ]; then
    echo "✓ Shared module exists"
    if grep -q "variable \"environment\"" "modules/sample_module/main.tf"; then
        echo "✓ Module accepts environment variable"
    fi
    if grep -q "output \"message\"" "modules/sample_module/main.tf"; then
        echo "✓ Module provides output"
    fi
else
    echo "✗ Module missing"
fi
echo ""

echo "=========================================="
echo "Structure validation complete!"
echo "=========================================="
echo ""
echo "To test with Terraform:"
echo "  1. Install Terraform: https://www.terraform.io/downloads"
echo "  2. cd dev && terraform init"
echo "  3. terraform plan"
echo "  4. terraform apply"
