package servlets;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.BeanLocal;
import entities.FourImages;
import entities.Lessons;
import entities.Translations;
import entities.Users;
import entities.Words;

/**
 * Servlet implementation class Test
 */
@WebServlet("/action")
public class Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	BeanLocal bean;

	public Action() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String page = request.getParameter("page");
		if (page.equals("signup")) {
			request.getRequestDispatcher("signup.jsp").forward(request, response);
		}
		if (page.equals("done")) {
			Long lid = Long.parseLong(request.getParameter("lid"));
			String lesson = bean.getNameByLid(lid);
			request.setAttribute("lesson", lesson);
			request.getRequestDispatcher("done.jsp").forward(request, response);
		}
		if (page.equals("index")) {
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
		if (page.equals("combine")) {
			Long lid = Long.parseLong(request.getParameter("lid"));
			List<Words> list = bean.getAllWords(lid);
			Long uid = Long.parseLong(request.getParameter("uid"));
			request.setAttribute("lid", lid);
			request.setAttribute("uid", uid);
			request.setAttribute("allWords", list);
			request.getRequestDispatcher("combine.jsp").forward(request, response);
		}
		if (page.equals("admin")) {
			List<Lessons> lessons = bean.getAllLessons();
			// List<Users> users = bean.getAllUsers();
			request.setAttribute("lessons", lessons);
			// request.setAttribute("users", users);
			request.getRequestDispatcher("admin.jsp").forward(request, response);
		}
		if (page.equals("translation")) {
			Long lid = Long.parseLong(request.getParameter("lid"));
			Long uid = Long.parseLong(request.getParameter("uid"));
			List<Words> list = bean.getAllWords(lid);
			List<Translations> allTranslations = bean.getAllTranslations(lid);
			request.setAttribute("lid", lid);
			request.setAttribute("uid", uid);
			request.setAttribute("allWords", list);
			request.setAttribute("allTrans", allTranslations);
			request.getRequestDispatcher("translation.jsp").forward(request, response);
		}
		if (page.equals("profile")) {
			Long lid = Long.parseLong(request.getParameter("lid"));
			Long uid = Long.parseLong(request.getParameter("uid"));
			List<Words> list = bean.getAllWords(lid);
			List<Translations> allTranslations = bean.getAllTranslations(lid);
			request.setAttribute("lid", lid);
			request.setAttribute("uid", uid);
			request.setAttribute("allWords", list);
			request.setAttribute("allTrans", allTranslations);
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		}
		if (page.equals("lessons")) {
			List<Words> list = bean.getAllWords(null);
			List<Lessons> allLessons = bean.getAllLessons();
			request.setAttribute("allWords", list);
			request.setAttribute("allLessons", allLessons);
			request.getRequestDispatcher("lessons.jsp").forward(request, response);
		}
		if (page.equals("images")) {
			Long lid = Long.parseLong(request.getParameter("lid"));
			List<FourImages> list = bean.getAllImages(lid);
			Long uid = Long.parseLong(request.getParameter("uid"));
			request.setAttribute("lid", lid);
			request.setAttribute("uid", uid);
			request.setAttribute("images", list);
			request.getRequestDispatcher("images.jsp").forward(request, response);
		}
		if (page.equals("logout")) {
			HttpSession ses = request.getSession();
			ses.invalidate();
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
		if (page.equals("my_profile")) {
			request.getRequestDispatcher("my_profile.jsp").forward(request, response);
		}
		if (page.equals("my_dragon")) {
			Long uid = Long.parseLong(request.getParameter("uid"));
			Users user = bean.getInfo(uid);
			request.setAttribute("points", user.getPoints());
			request.getRequestDispatcher("my_dragon.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String page = request.getParameter("page");
		if (page.equals("register")) {
			String login = request.getParameter("login");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String surname = request.getParameter("surname");
			bean.addUser(login, password, name, surname);
			response.sendRedirect("action?page=index");
		}
		if (page.equals("check")) {
			String login = request.getParameter("login");
			String password = request.getParameter("password");
			request.getSession().setAttribute("user", bean.checkLogin(login, password));
			Users user = (Users) request.getSession().getAttribute("user");
			if (user.getRole() == 0)
				response.sendRedirect("action?page=lessons");
			else
				response.sendRedirect("action?page=admin");
		}
		if (page.equals("add_task1"))

		{
			String word = request.getParameter("word");
			String truth = request.getParameter("translation");
			String miss1 = request.getParameter("miss1");
			String miss2 = request.getParameter("miss2");
			String miss3 = request.getParameter("miss3");

			byte[] bytes = word.getBytes(StandardCharsets.ISO_8859_1);
			word = new String(bytes, StandardCharsets.UTF_8);

			bean.addWord(word, 1L);
			Long wid = bean.getWidByName(word);
			bean.addTranslations(wid, truth, 1);
			bean.addTranslations(wid, miss1, 0);
			bean.addTranslations(wid, miss2, 0);
			bean.addTranslations(wid, miss3, 0);
			response.sendRedirect("action?page=admin");
		}
		if (page.equals("answer")) {
			request.setCharacterEncoding("utf-8");
			String myField = request.getParameter("myField");
			Long lid = Long.parseLong(request.getParameter("lid"));
			Long wid = Long.parseLong(request.getParameter("wid"));
			Long uid = Long.parseLong(request.getParameter("uid"));
			String translation = bean.getTransByWid(wid);
			if (!myField.equals(translation)) {
				bean.addMisses(wid, uid);
			} else {
				bean.addPoint(uid);
			}
			response.sendRedirect("action?page=combine&lid=" + lid + "&uid=" + uid);
		}
		if (page.equals("answer_tr")) {
			request.setCharacterEncoding("utf-8");
			String myField = request.getParameter("myField");
			Long lid = Long.parseLong(request.getParameter("lid"));
			Long tid = Long.parseLong(request.getParameter("tid"));
			Long uid = Long.parseLong(request.getParameter("uid"));
			Long wid = bean.getWordByTid(tid);
			String word = bean.getWordByWid(wid);
			if (!myField.equals(word)) {
				bean.addMisses(wid, uid);
			} else {
				bean.addPoint(uid);
			}
			response.sendRedirect("action?page=done&lid=" + lid);
		}
		if (page.equals("usach")) {
			request.setCharacterEncoding("utf-8");
			Long wid = Long.parseLong(request.getParameter("wid"));
			Long lid = Long.parseLong(request.getParameter("lid"));
			Long uid = Long.parseLong(request.getParameter("uid"));
			String word = request.getParameter("demo");
			String wordByWid = bean.getWordByWid(wid);
			if (!word.equals(wordByWid)) {
				bean.addMisses(wid, uid);
			} else {
				bean.addPoint(uid);
			}
			response.sendRedirect("action?page=images&lid=" + lid + "&uid=" + uid);
		}
		if (page.equals("four")) {
			String four = request.getParameter("four");
			Long uid = Long.parseLong(request.getParameter("uid"));
			Long wid = Long.parseLong(request.getParameter("wid"));
			Long lid = Long.parseLong(request.getParameter("lid"));
			String wordByWid = bean.getWordByWid(wid);
			if (!four.equals(wordByWid)) {
				bean.addMisses(wid, uid);
			} else {
				bean.addPoint(uid);
			}
			response.sendRedirect("action?page=translation&lid=" + lid + "&uid=" + uid);
		}
		if (page.equals("add_lesson")) {
			request.setCharacterEncoding("utf-8");
			String lesson = request.getParameter("lesson");
			String name = "Урок " + lesson;
			bean.addLesson(name);
			response.sendRedirect("action?page=admin");
		}
	}
}
