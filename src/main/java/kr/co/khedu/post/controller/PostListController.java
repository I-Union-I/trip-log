package kr.co.khedu.post.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.khedu.post.model.dto.PostSummaryDTO;
import kr.co.khedu.post.service.PostServiceImpl;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/post/list")
public final class PostListController extends HttpServlet {

    /*
      TODO
        1. 정렬 선택 구현
        2. 국가 카테고리 구현
        3. 페이징 UI 수정
        4. JSP 스크립트들 EL로 전환
    */

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = Optional.ofNullable(request.getParameter("page"))
                .map(Integer::parseInt)
                .orElse(1);

        List<? extends PostSummaryDTO> posts = new PostServiceImpl().getPostSummaries(page);

        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/WEB-INF/views/post/list.jsp").forward(request, response);
    }
}
