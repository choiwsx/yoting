package org.kitchen.exception_h;

public class UserDuplicatedException extends Exception {
	public UserDuplicatedException() {
        super("아이디 혹은 이멜 중복");
    }
}
