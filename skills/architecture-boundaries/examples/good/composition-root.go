package main

func main() {
	gateway := NewStripeGateway(loadStripeConfig())
	checkout := checkout.NewCheckout(gateway)
	startHTTPServer(checkout)
}

// Infrastructure is assembled at the edge. The application does not create
// its own provider or read a package-global client.
