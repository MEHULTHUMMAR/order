package com.croods.student.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.croods.student.model.Project;
import com.croods.student.model.ProjectManager;
import com.croods.student.model.Student;
import com.croods.student.repo.ProjectManagerRepository;
import com.croods.student.repo.ProjectRepository;
import com.croods.student.repo.StudentRepo;
import com.croods.student.service.StudentService;

@Controller
@RequestMapping("/")
public class StudentController {
	
	@Autowired
	StudentRepo studentRepo;

	@Autowired
	StudentService studentService;
	
	
	@Autowired
	ProjectRepository projectRepository;

	@Autowired
	ProjectManagerRepository projectManagerRepository;
	
	@GetMapping(value = {"","/"})
	public String index() 
	{		
		return "xyz";
	}

	@PostMapping("/xyz")
	public String saveStudent(@ModelAttribute Student s) 
	{		
		//studentRepo.save(s);
		studentService.Registration(s);
		return "redirect:/std";
	}
	
	
	
	//--------- main url ------------------------------------------------------------------
	@GetMapping("/std")
	public String mainstudent(Model m) 
	{		
	//	m.addAttribute("students", studentRepo.findTop1000ByOrderBySidDesc());
		return "main2";
	}
	
	//------------------data table--------------------------------------------------------------
	@RequestMapping("/std/data")
	@ResponseBody
	public DataTablesOutput<Student> getUsers(@RequestBody DataTablesInput input) 
	{
		//System.out.println("000000000000");
	  return studentRepo.findAll(input);
	}
	
	@PostMapping("/main")
	public String savestd(@ModelAttribute Student s) 
	{		
		studentRepo.save(s);
		return "redirect:/std";
	}
	
	//---------------------------add detail---------------------------------------------------------
	@PostMapping("/student/add")
	@ResponseBody
	public Student savestd2(@ModelAttribute Student s) 
	{		
		//System.out.println(s.getSname());
		return studentRepo.save(s);

	}

	//------------------------delete controller------------------------------------------------------
	@GetMapping("/student/delete/{id}")
	@ResponseBody
	public String delstd(@PathVariable long id) 
	{	
		studentRepo.deleteById(id);
		
		return "true";
	}
	
	//--------------------------edit controller----------------------------------------------------------
	@GetMapping("/edit/{id}")
	@ResponseBody
	public Optional<Student> editstudent(@PathVariable long id,Model m) 
	{		
	    
		return studentRepo.findById(id);
	}

	@PostMapping("/edit")
	public String saveStd(@ModelAttribute Student s) 
	{		
		studentRepo.save(s);
		return "redirect:/std";
	}
	//--------------------------------------------------------------------------
	
	
	
	@GetMapping("/students")
	@ResponseBody
	public List<Student> getAllStudents() 
	{		
		return studentRepo.findTop10ByOrderBySidDesc();
	}

	@GetMapping("/students/{id}")
	@ResponseBody
	public Student getStudent(@PathVariable long id) 
	{		
		return studentRepo.findById(id).orElse(null);
	}
	
	@GetMapping("/find/{mob}/{sname}")
	@ResponseBody
	public Student getStudent(@PathVariable String mob,@PathVariable String sname) 
	{		
		return studentRepo.xyz(mob,sname);
	}
	
	
	
	
	
	//---------------------------project and manager controller --------------------------------------------------
	@GetMapping("/managers")
	@ResponseBody
	public List<ProjectManager> getAllManagers() 
	{		
		return projectManagerRepository.findAll();
	}
	
	
	@GetMapping("/projects")
	@ResponseBody
	public List<Project> getAllMzanagers() 
	{		
		return projectRepository.findAll();
	}

	
	@GetMapping("/project")
	public String newProject() 
	{		
		return "Project";
	}
	
	@PostMapping("/project/save")
	public String saveProject(@ModelAttribute Project p) 
	{
		
		projectRepository.save(p);
	
		return "index";
	}
	

// ---------------add data in database-------------------------------------------------------------	
	@GetMapping("/xyz")
	public String xyz() 
	{		
		
		for(int i=4217;i<=50000;i++) 
		{
			Student s=new Student();
			s.setSname("student-"+i);
			s.setSmob("99999"+i);
			
			studentRepo.save(s);
			
		}
		
		
		return "Project";
	}


}
