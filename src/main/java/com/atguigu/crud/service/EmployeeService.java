package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;
@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll(){
		//�ⲻ��һ����ҳ��ѯ
		
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}
	
	//����Ա�������Ƿ����(�ظ�������)
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count==0;
	}
	//��ȡԱ����Ϣ
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	//Ա������
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	//Ա��ɾ��
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxxx where emp_id in
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
		
	}

}
