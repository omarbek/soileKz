package beans;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import entities.FourImages;
import entities.Lessons;
import entities.Translations;
import entities.UserWords;
import entities.Users;
import entities.Words;

/**
 * Session Bean implementation class Bean
 */
@Stateless
@LocalBean
public class Bean implements BeanLocal {// comment

	@PersistenceContext(unitName = "soileKzPU")
	private EntityManager em;

	@Override
	public void addUser(String login, String password, String name, String surname) {

		Users u = new Users();
		u.setLogin(login);
		u.setPassword(password);
		u.setName(name);
		u.setSurname(surname);
		u.setRole(0);

		em.persist(u);
	}

	@Override
	public Users checkLogin(String login, String password) {
		Users user = null;
		Query query = em.createQuery("SELECT u from Users u WHERE u.login=:login and u.password=:password")
				.setParameter("login", login).setParameter("password", password);
		user = (Users) query.getSingleResult();
		return user;
	}

	@Override
	public Users getInfo(Long id) {
		Users user = null;
		Query query = em.createQuery("SELECT u FROM Users u where u.id=:uid").setParameter("uid", id);
		user = (Users) query.getSingleResult();
		return user;
	}

	@Override
	public void change(Long id, String pass1, String pass2) {
		Users u = new Users();
		Query query = em.createQuery("SELECT u from Users u WHERE u.id=:id").setParameter("id", id);
		u = (Users) query.getSingleResult();
		u.setPassword(pass1);
		em.persist(u);

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Words> getAllWords(Long lid) {
		if (lid == null) {
			return (List<Words>) em.createNativeQuery("select * from words where removed=0", Words.class)
					.getResultList();
		}
		return (List<Words>) em.createNativeQuery("select * from words where removed=0 and lid=:lid", Words.class)
				.setParameter("lid", lid).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Translations> getAllTranslations(Long lid) {
		return (List<Translations>) em.createNativeQuery(
				"select t.* from translations t left join words w on w.id=t.wid where w.removed=0 and w.lid=:lid",
				Translations.class).setParameter("lid", lid).getResultList();
	}

	@Override
	public void addWord(String name, Long uid) {
		// Words words = new Words();
		// words.setUid(uid);
		// words.setName(name);
		// words.setLid(1L);
		// words.setUrl("http://www.psychologos.ru/images/idealnaya_mama_1_1397190850.jpg");
		// words.setRemoved(0);
		//
		// em.persist(words);
	}

	@Override
	public Long getWidByName(String word) {
		Long words = null;
		Query query = em.createQuery("SELECT u.id FROM Words u WHERE u.name=:name").setParameter("name", word);
		words = (Long) query.getSingleResult();
		return words;
	}

	@Override
	public void addTranslations(long wid, String name, int truth) {
		// Translations tr = new Translations();
		// tr.setWid(wid);
		// tr.setName(name);
		// tr.setTruth(truth);
		// tr.setRemoved(0);
		//
		// em.persist(tr);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Lessons> getAllLessons() {
		List<Lessons> all = null;
		all = (List<Lessons>) em.createNativeQuery("select * from lessons where removed=0", Lessons.class)
				.getResultList();
		return all;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FourImages> getAllImages(Long lid) {
		List<FourImages> all = null;
		all = (List<FourImages>) em
				.createNativeQuery("select i.* from four_images i left join words w on w.id=i.wid"
						+ " where w.removed=0 and w.lid=:lid", FourImages.class)
				.setParameter("lid", lid).getResultList();
		return all;
	}

	@Override
	public void addMisses(Long wid, Long uid) {
		UserWords m = new UserWords();
		m.setWid(wid);
		m.setUid(uid);

		em.persist(m);
	}

	@Override
	public String getTransByWid(Long wid) {
		String trans = null;
		Query query = em.createQuery("SELECT t.name FROM Translations t WHERE t.wid=:wid").setParameter("wid", wid);
		trans = (String) query.getSingleResult();
		return trans;
	}

	@Override
	public String getWordByWid(Long wid) {
		String word = null;
		Query query = em.createQuery("SELECT w.name FROM Words w WHERE w.id=:wid").setParameter("wid", wid);
		word = (String) query.getSingleResult();
		return word;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Users> getAllUsers() {
		List<Users> all = null;
		all = (List<Users>) em.createNativeQuery("select * from users where removed=0", Users.class).getResultList();
		return all;
	}

	@Override
	public void addLesson(String lesson) {
		Lessons lessons = new Lessons();
		lessons.setName(lesson);

		em.persist(lessons);
	}

	@Override
	public Long getWordByTid(Long tid) {
		Long wid = null;
		Query query = em.createQuery("SELECT t.id FROM Translations t WHERE t.id=:tid").setParameter("tid", tid);
		wid = (Long) query.getSingleResult();
		return wid;
	}

	@Override
	public String getNameByLid(Long lid) {
		String l = null;
		Query query = em.createQuery("SELECT l.name FROM Lessons l WHERE l.id=:lid").setParameter("lid", lid);
		l = (String) query.getSingleResult();
		return l;
	}

	@Override
	public void addPoint(Long uid) {
		em.createQuery("update Users set points=points+1 where id=:uid").setParameter("uid", uid).executeUpdate();
	}
}
