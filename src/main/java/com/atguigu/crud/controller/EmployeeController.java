package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	/**
	 * ����ɾ��������ɾ������һ
	 * ���ɾ��:������id  1-2-3
	 * ����ɾ��:����һ��id
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			List<Integer> delIds = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//��װid�ļ���
			for (String string : str_ids) {
				delIds.add(Integer.parseInt(string));
			}
			
			employeeService.deleteBatch(delIds);
		}else{
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	/**
	 * Ա������
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		System.out.println("��Ҫ���µ�Ա������: "+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	/**
	 * ��ȡԱ����Ϣ
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	
	
	/**
	 * ����û����Ƿ����
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName){
		//���ж��û����Ƿ��ǺϷ��ı��ʽ
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg", "������ʽΪ2-5λ�ַ���3-16λ���ֺ���ĸ���");
		}
		//���ݿ�Ա�������ظ�У��
		boolean b = employeeService.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "�û���������");
		}
	}
	/**
	 * �����½���Ա����Ϣ
	 * @param employee
	 * @param result
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors())
		{
			Map<String,Object> map = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError : errors){
				System.out.println("������ֶ���: "+fieldError.getField());
				System.out.println("������Ϣ: "+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	/**
	 * ��Ҫ����Jackson�İ�
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn)
	{
		PageHelper.startPage(pn, 12);//ÿҳ��ʾ15��
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo",page);
	}
	/**
	 * ��ѯԱ������(��ҳ��ѯ)
	 * @return 
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){		
		PageHelper.startPage(pn, 12);//ÿҳ��ʾ15��
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps,5);//��ҳ��
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
