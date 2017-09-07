//package com.atguigu.crud.test;
//
//import org.apache.ibatis.session.SqlSession;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.test.context.ContextConfiguration;
//
//import com.atguigu.crud.dao.DepartmentMapper;
//import com.atguigu.crud.dao.EmployeeMapper;
//
////@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"classpath:applicationContext.xml"})
//public class MapperTest {
//	@Autowired
//	DepartmentMapper departmentMapper;
//	@Autowired
//	EmployeeMapper employeeMapper;
//	@Autowired
//	SqlSession sqlSession;
//	/**
//	 * ����departmentMapper
//	 */
//	/*@Test
//	public void testCRUD(){
//		System.out.println(departmentMapper);
////		departmentMapper.insertSelective(new Department(null,"������"));
////		departmentMapper.insertSelective(new Department(null,"���Բ�"));
////		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
//		//��������   ʹ��UUID
//		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
//		for(int i = 0;i<1000;i++){
//			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
//			mapper.insertSelective(new Employee(null, uid, "M", uid+"@atguigu.com", 1));
//			
//		}
//		System.out.println("�������!");
//	}*/
//}
