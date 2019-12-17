package com.croods.Order.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.croods.Order.Repo.CustomerRepo;
import com.croods.Order.Repo.OrderItemRepo;
import com.croods.Order.Repo.OrderRepo;
import com.croods.Order.Repo.ProductRepo;
import com.croods.Order.model.Customer;
import com.croods.Order.model.Order;
import com.croods.Order.model.Product;

@Controller
@RequestMapping("/")
public class OrderController {
	@Autowired
	CustomerRepo customerRepo;
	@Autowired
	ProductRepo productRepo;
	@Autowired
	OrderRepo orderrepo;
	@Autowired
	OrderItemRepo orderitemrepo;
	
	// product add controller---------------------------------------------------------------------------------
	@GetMapping("/product")
	public String product() 
	{		
		return "Product";
	}

	@PostMapping("/product/save")
	public String saveProduct(@ModelAttribute Product p) 
	{		
		productRepo.save(p);
		return "redirect:/product";
	}
	
	//find all product------------------------------------------
	@GetMapping("/allproduct")
	@ResponseBody
	public List<Product> getAllproduct() 
	{		
		return productRepo.findAll();
	}
	
	//find product by id---------------------------------------
	@GetMapping("/allproduct/{id}")
	@ResponseBody
	public Product getproduct(@PathVariable long id) 
	{		
		return productRepo.findById(id).orElse(null);
	}
	
    //find product by name------------------------------------
	@GetMapping("/allproducts/{pname}")
	@ResponseBody
	public Product getproducts(@PathVariable String pname) 
	{		
		return productRepo.findByPname(pname);
	}
	

	
	// Customer add controller---------------------------------------------------------------------------------
		@GetMapping("/customer")
		public String customer() 
		{		
			return "Customer";
		}

		@PostMapping("/customer/save")
		public String saveCustomer(@ModelAttribute Customer c) 
		{		
			customerRepo.save(c);
			return "redirect:/customer";
		}
		
		//find all customer---------------------------------------------
		@GetMapping("/allcustomer")
		@ResponseBody
		public List<Customer> getAllCustomer() 
		{		
			return customerRepo.findAll();
		}
		
		//order controller----------------------------------------------------------------------------------------
		
		@GetMapping(value = {"","/","/order"})
	public String addorder(/* Model m */) 
		{		
		/* m.addAttribute("customers", customerRepo.findAll()); */
			return "order";
		}

		@GetMapping("/customer/delete/{id}")
		public String delcust(@PathVariable long id) 
		{	
			customerRepo.deleteById(id);
			
			return "redirect:/";
		}

		@PostMapping("/order/save")
		public String saveorder(@ModelAttribute Order o ) 
		{		
			System.out.println("o");
		
		  System.out.println(o.getOrderitem().get(0).getQuantity());
		 		
			o.getOrderitem().forEach(oi->
			{
			oi.setOrder(o);
			
			});
			
			orderrepo.save(o);
			return "redirect:/order";
		}

}
