# Rule Lifecycle

Use this lifecycle when deciding whether an observation should change a global Skill.

## 1. Observation

Record the concrete situation, the user-visible effect, the project context, and the evidence. Do not start with a universal rule.

## 2. Repeated pattern

Compare the observation with other projects, reviews, incidents, or eval cases. Identify what is stable and what was specific to the original project.

## 3. Candidate rule

Write a narrow Rule, Why, Do, Do not, and Verification. State the trigger and the boundary where the rule stops applying.

## 4. Eval case

Add at least one case that should trigger the rule and one case that should not trigger it. Include the over-application failure mode.

## 5. Real-project validation

Use the candidate in real work. Check whether it improves decisions without increasing unnecessary abstraction, ceremony, or scope.

## 6. Promotion

Promote only when the pattern is repeated across independent contexts, follows a costly incident, or is repeatedly found in review. Record the reason in CHANGELOG.md.

## Rejection criteria

Keep the rule local when it depends on a framework, team convention, schema, vendor, one-off migration, or an unverified preference.
