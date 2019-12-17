package com.croods.student.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "tbl_student")
public class Student 
{
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "student_id")
	private long sid;

	@Column(name = "student_name")
	private String sname;
	
	@Column(name = "student_mob")
	private String smob;
}
