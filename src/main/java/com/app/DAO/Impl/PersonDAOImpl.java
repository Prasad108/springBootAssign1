package com.app.DAO.Impl;

import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import javax.persistence.criteria.*;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.app.DAO.PersonDAO;
import com.app.pojo.Person;


@Repository("PersonDAO")
public class PersonDAOImpl implements PersonDAO {
	/*
	@PersistenceContext	
	private EntityManager sessionFactory;	
	*/
	@Autowired
	private SessionFactory sessionFactory;
	
	
	
	 
	 protected Session currentSession() {
		 return this.sessionFactory.getCurrentSession();
	 }

	@Override
	@Transactional
	public void create(Person person) {
		currentSession().save(person);

	}

	@Override
	@Transactional
	public void update(Person person) {
		currentSession().update(person);

	}

	@Override
	@Transactional
	public Person edit(int id) {
		return find(id);
	}

	@Override
	@Transactional
	public void delet(Person person) {
		currentSession().delete(person);

	}

	@Override
	@Transactional
	public Person find(int id) {
		return (Person)currentSession().get(Person.class,id);
	}

	@Override
	@Transactional
	public List<Person> getall() {
		CriteriaBuilder builder = currentSession().getCriteriaBuilder();
        CriteriaQuery<Person> query = builder.createQuery(Person.class);
        Root<Person> root = query.from(Person.class);
        query.select(root);
        Query<Person> q=currentSession().createQuery(query);
        List<Person> persons=q.getResultList();
		
		return persons;
	}

}
