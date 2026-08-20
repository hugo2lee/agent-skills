package order

type Order struct {
	status Status
	total  Money
}

func (o *Order) Confirm() error {
	if o.total.IsZero() {
		return ErrEmptyOrder
	}
	if o.status != Draft {
		return ErrInvalidTransition
	}
	o.status = Confirmed
	return nil
}

// The Aggregate exists because confirmation protects a real invariant and
// state transition. It is not present merely because an orders table exists.
