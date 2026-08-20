package order

type Order struct {
	ID        string
	Status    string
	CreatedAt time.Time
}

func SaveOrder(order Order) error {
	return database.Insert("orders", order)
}

// This model exposes storage fields without expressing a business invariant.
// It is not improved by renaming the table row to an Aggregate.
