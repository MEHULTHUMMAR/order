package com.croods.Order.Service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.croods.Order.Repo.OrderRepo;
import com.croods.Order.model.Order;
@Service
@Transactional
public class OrderServiceImpl implements OrderSevice {

	@Autowired OrderRepo or;
	@Override
	public Order saveorder(Order o) {
		// TODO Auto-generated method stub
		return or.save(o);
	}

}
