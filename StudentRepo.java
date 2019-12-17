package com.croods.student.repo;

import java.util.List;

import org.springframework.data.jpa.datatables.repository.DataTablesRepository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.croods.student.model.Student;

@Repository
public interface StudentRepo extends JpaRepository<Student, Long>, DataTablesRepository<Student, Long>
{
	
//	  @Query("select s from Student s where s.smob = ?1")
	
	  List<Student> findTop10ByOrderBySidDesc();
	  List<Student> findTop1000ByOrderBySidDesc();
	  
	  @Query(value = "select *from tbl_student where student_mob=:mob and student_name=:sname",nativeQuery = true)
	  Student xyz(@Param("mob") String mob,@Param("sname") String sname);

}
