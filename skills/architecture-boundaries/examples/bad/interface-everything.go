package user

type UserService interface {
	Create(User) error
}

type UserMapper interface {
	Map(User) Record
}

type UserValidator interface {
	Validate(User) error
}

// These interfaces protect no meaningful boundary. They add indirection
// without a substitution, protocol, or independent test requirement.
