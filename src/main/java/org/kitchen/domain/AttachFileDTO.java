package org.kitchen.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private String showFileName;
	private boolean image;
	
}
