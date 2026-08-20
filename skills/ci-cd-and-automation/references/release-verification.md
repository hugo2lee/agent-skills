# Release Verification

Verify the identity of the artifact that was built, tested, and deployed. After deployment, check the health signal and a representative behavior.

Define:

- the stop condition;
- the retry policy;
- the rollback or forward-fix path;
- the evidence retained for diagnosis;
- the owner for manual intervention.

Do not treat a successful upload or process start as proof that user-visible behavior is healthy.
