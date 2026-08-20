package checkout

func NewCheckout() *Checkout {
	repository := NewPostgresRepository()
	gateway := NewStripeGateway()
	return &Checkout{repository: repository, gateway: gateway}
}

// The application constructs infrastructure and hides its dependencies.
