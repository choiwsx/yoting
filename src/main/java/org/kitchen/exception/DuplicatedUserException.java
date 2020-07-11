package org.kitchen.exception;

public class DuplicatedUserException extends Exception {
	public DuplicatedUserException(String string) {
        super(string+"  중복");
    }
}
