# KNIME workflow availability

The workflow was completed and evaluated in KNIME Analytics Platform. The available `.knwf` export did not pass a file-integrity check, so it is not included here as executable source. The repository instead retains the workflow overview and the report containing the evaluated model results.

To reproduce the workflow from a verified export:

1. Open the original completed workflow in KNIME Analytics Platform.
2. Select **File → Export KNIME Workflow**.
3. Export the full workflow as `loan_repayment_classification.knwf`.
4. Test-import the exported file into a new local workspace.
5. Update the CSV Reader path to an authorised local copy of `trainData.csv`.
6. Place the tested export in this folder as `loan_repayment_classification.knwf`.

The workflow structure and validated model results are preserved in `../images/knime_workflow.png` and `../docs/classification_report.pdf`.
