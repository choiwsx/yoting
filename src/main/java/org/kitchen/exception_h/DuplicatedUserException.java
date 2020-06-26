package org.kitchen.exception_h;

public class DuplicatedUserException extends Exception {
	public DuplicatedUserException(String string) {
        super(string+"  중복");
    }
}
