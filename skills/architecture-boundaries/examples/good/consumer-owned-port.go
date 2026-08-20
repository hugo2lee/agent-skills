package checkout

import "context"

type PaymentGateway interface {
	Authorize(context.Context, Money) (Authorization, error)
}

type Checkout struct {
	payments PaymentGateway
}

func NewCheckout(payments PaymentGateway) *Checkout {
	return &Checkout{payments: payments}
}

// The contract expresses the capability Checkout needs, not the SDK surface
// of a particular payment provider.
