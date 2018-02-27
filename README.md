# PwndPassword

An easy to use Swift library for validating passwords against
the awesome pwnedpasswords.com API.

## Requirements

A box that runs the Swift4.0 toolchain.

## Usage
```
let password = PwndPassword()
password.validate(password: "somePassword") {
	(result) in
	if result == 0 {
		print("Good news, not powned!")
	}
}
```

The function returns -1 on error, 0 on none found and a postive number
when found and the number of times it has been found.
