# Good Debugging Trace

## Symptom

One checkout request returns a timeout after the payment provider responds.

## Facts

- The provider response is present in the adapter log.
- The application never records the checkout completion event.
- The failure started after a retry change.

## Hypothesis

The retry path may acknowledge the provider twice and block on an idempotency
lock.

## Experiment

Replay one request with the same idempotency key and trace lock acquisition.

## Fix and verification

Restore the idempotent transition, add a regression test for repeated keys, and
run the original reproduction plus the checkout integration suite.
