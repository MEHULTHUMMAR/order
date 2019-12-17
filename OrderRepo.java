package com.croods.Order.Repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.croods.Order.model.Order;

public interface OrderRepo extends JpaRepository<Order, Long> {

}
