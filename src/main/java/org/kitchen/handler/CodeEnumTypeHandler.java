package org.kitchen.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.kitchen.enums.CodeEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CodeEnumTypeHandler<E extends Enum<E>> implements TypeHandler<CodeEnum> {
	
	private static final Logger log = LoggerFactory.getLogger(CodeEnumTypeHandler.class);

	private Class <E> type;
	
	public CodeEnumTypeHandler(Class <E> type) {
		this.type = type;
	}

    @Override
    public void setParameter(PreparedStatement ps, int i, CodeEnum parameter, JdbcType jdbcType) throws SQLException {
    	String code = parameter==null?"1":parameter.getCode();
        ps.setString(i, code);
        log.info("1"+code);
    }
 
    @Override
    public CodeEnum getResult(ResultSet rs, String columnName) throws SQLException {
        String code = rs.getString(columnName);
        log.info("2"+code);

        return getCodeEnum(code);
    }
 
    @Override
    public CodeEnum getResult(ResultSet rs, int columnIndex) throws SQLException {
        String code = rs.getString(columnIndex);
        log.info("3"+code);

        return getCodeEnum(code);
    }
 
    @Override
    public CodeEnum getResult(CallableStatement cs, int columnIndex) throws SQLException {
        String code = cs.getString(columnIndex);
        log.info("4"+code);

        return getCodeEnum(code);
    }
 
    private CodeEnum getCodeEnum(String code) {
    	if(code==null) code="1";
        try {
            CodeEnum[] enumConstants = (CodeEnum[]) type.getEnumConstants();
            log.info("enumConstants"+enumConstants+"code"+code);
            for (CodeEnum codeEnum: enumConstants) {      
            	log.info("########"+codeEnum.getCode()+"#"+code+"######");
            	log.info(codeEnum.toString());
                if (codeEnum.getCode().equals(code)) {
                	log.info("##########################"+codeEnum);
                    return codeEnum;
                }
            }
        } catch (Exception e) {
            log.info("#############ENUMHANDLE ERROR######################################");
        }
        return null;
    }
}
