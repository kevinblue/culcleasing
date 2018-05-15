package service;

import java.util.List;
import java.util.Map;

public interface PersonService {
  public <T> void saveEntity(T t) throws Exception;
  public <T> void updateEntity(T entity) throws Exception;
  public <T> void removeEntityById(T entity,String id) throws Exception;
  public <T> void removeAll(T entity) throws Exception;
  public <T> void removeEntity(T entity) throws Exception;
  public  <T> List<T> findEntityByID(Class<T> entityClass,T entity,String id)throws Exception;
  public  <T> List<T>  findAllEntity(Class<T> entityClass,Map<String,Object>  map)throws Exception;
  //public <T> T findEntityByID(Class<T> entityClass, String id) throws DataAccessException, Exception;

}
