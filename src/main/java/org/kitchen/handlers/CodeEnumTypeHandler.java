package org.kitchen.handlers;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.kitchen.enums.CodeEnum;

import lombok.extern.log4j.Log4j;

@Log4j
public class CodeEnumTypeHandler<E extends Enum<E>> implements TypeHandler<CodeEnum> {

	private Class <E> type;
	
	public CodeEnumTypeHandler(Class <E> type) {
		this.type = type;
	}

    @Override
    public void setParameter(PreparedStatement ps, int i, CodeEnum parameter, JdbcType jdbcType) throws SQLException {
    	String code = parameter==null?"1":parameter.getCode();
        ps.setString(i, code);

    }
 
    @Override
    public CodeEnum getResult(ResultSet rs, String columnName) throws SQLException {
        String code = rs.getString(columnName);
        return getCodeEnum(code);
    }
 
    @Override
    public CodeEnum getResult(ResultSet rs, int columnIndex) throws SQLException {
        String code = rs.getString(columnIndex);
        return getCodeEnum(code);
    }
 
    @Override
    public CodeEnum getResult(CallableStatement cs, int columnIndex) throws SQLException {
        String code = cs.getString(columnIndex);
        return getCodeEnum(code);
    }
 
    private CodeEnum getCodeEnum(String code) {
        try {
            CodeEnum[] enumConstants = (CodeEnum[]) type.getEnumConstants();
            for (CodeEnum codeNum: enumConstants) {           
                if (codeNum.getCode().equals(code)) {
                    return codeNum;
                }
            }
        } catch (Exception e) {
            log.info("#############ENUMHANDLE ERROR######################################");
        }
        return null;
    }
}
