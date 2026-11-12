# Testing

These rules guard against tests written to turn the suite green: they mirror the implementation, so they break on a refactor and catch no bug.

**A test checks what callers can observe, not how the code works.** Call the code through its API and assert a result, an error, or an effect a caller could notice. A good test fails when that behavior breaks, and still passes after a refactor that keeps it.

> Prefer: `expect(order.status).toBe("confirmed")`.
> Over: `expect(validateCart).toHaveBeenCalledBefore(computeTotal)`.

**The expected value comes from the requirement, not from the code.** A value computed the way the code computes it can never disagree with the code.

> Prefer: `expect(total([10, 5])).toBe(15)`.
> Over: `expect(total(items)).toBe(items.reduce((sum, i) => sum + i, 0))`.

**Fake only what you do not own.** Replace the network, the clock, or a third-party service, and run your own code for real. A test that mocks your own module tests the mock.

**A test that is hard to write is feedback on the design.** When a test needs unrelated setup or reaches for a private member, the logic sits away from its owner. Move the logic per [abstraction.md](abstraction.md), and the test gets simple.

**Test where a break would cost something.** One test that fails when risky logic breaks is worth more than coverage. Prefer no test over one that fails the rules above.

**A bug fix comes with a test that failed before the fix.** Run it against the old code and watch it fail for the right reason.

**Change a failing test only when the behavior was meant to change.** A weakened assertion or a skipped test turns the suite green and proves nothing.
