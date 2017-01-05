package beans;

import java.util.List;

import javax.ejb.Local;

import entities.FourImages;
import entities.Lessons;
import entities.Translations;
import entities.Users;
import entities.Words;

@Local
public interface BeanLocal {

	public void addUser(String login, String password, String name, String surname);

	public Users checkLogin(String login, String password);

	public Users getInfo(Long id);

	public void change(Long id, String pass1, String pass2);

	public List<Translations> getAllTranslations(Long lid);

	public List<Words> getAllWords(Long lid);

	public void addMisses(Long wid, Long uid);

	public void addWord(String name, Long uid);

	public Long getWidByName(String word);

	public void addTranslations(long wid, String name, int truth);

	public List<Lessons> getAllLessons();

	public List<FourImages> getAllImages(Long lid);

	public String getTransByWid(Long wid);

	public String getWordByWid(Long wid);

	public List<Users> getAllUsers();

	public void addLesson(String lesson);

	public Long getWordByTid(Long tid);

	public String getNameByLid(Long lid);

	public void addPoint(Long uid);
}
