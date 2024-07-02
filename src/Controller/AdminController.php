<?php

namespace App\Controller;

use App\Entity\Course;
use App\Entity\Student;
use Doctrine\ORM\EntityManagerInterface;
use phpDocumentor\Reflection\Types\This;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Form\StudentType;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    public function index(): Response
    {
        return $this->render('admin/index.html.twig', []);
    }

    #[Route('/admin/student/new', name: 'app_admin_student_new')]
    public function newStudent(EntityManagerInterface $em, Request $req): Response
    {

        $student = new Student();
        $form = $this->createForm(StudentType::class, $student);

        $form->handleRequest($req);
        if ($form->isSubmitted() && $form->isValid())
        {
            $student = $form->getData();

            // Checking if the student can follow the selected courses
            $age = $student->getAge();
            foreach ($student->getCourses() as $course)
            {
                if ($age < $course->getMinimumAge()) {
                    $student->removeCourse($course);
                    $this->addFlash("warning", "Kon het vak " . $course->getName() . " niet toevoegen: Student te jong");
                }
            }

            $em->persist($student);
            $em->flush();
            $this->addFlash("success", "Student toegevoegd!");
//            Redirect so that you cant refresh and spam the same post request
            return $this->redirectToRoute("app_admin_student_new");
        }

        return $this->render('admin/new_student.html.twig', ['form'=>$form]);
    }

    #[Route('/admin/students', name: 'app_admin_student_list')]
    public function listStudents(EntityManagerInterface $em): Response
    {
        $students = $em->getRepository(Student::class)->findAll();

        return $this->render('admin/show_students.html.twig', [
            'students' => $students
        ]);
    }


    #[Route('/admin/student/{id}/delete', name: 'app_admin_student_delete')]
    public function deleteStudent(EntityManagerInterface $em, int $id): Response
    {
        $student = $em->getRepository(Student::class)->find($id);
        $em->remove($student);
        $em->flush();
        $this->addFlash("success", "Student verwijderd!");
        return $this->redirectToRoute("app_admin_student_list");
    }


    #[Route('/admin/student/{id}/edit', name: 'app_admin_student_edit')]
    public function editStudent(EntityManagerInterface $em, Request $req, int $id): Response
    {

        $student = $em->getRepository(Student::class)->find($id);
        $form = $this->createForm(StudentType::class, $student);

        $form->handleRequest($req);
        if ($form->isSubmitted() && $form->isValid())
        {
            $student = $form->getData();

            // Checking if the student can follow the selected courses
            $age = $student->getAge();
            foreach ($student->getCourses() as $course)
            {
                if ($age < $course->getMinimumAge()) {
                    $student->removeCourse($course);
                    $this->addFlash("warning", "Kon het vak " . $course->getName() . " niet toevoegen: Student te jong");
                }
            }

            $em->persist($student);
            $em->flush();
            $this->addFlash("success", "Student aangepast!");
//            Redirect so that you cant refresh and spam the same post request
            return $this->redirectToRoute("app_admin_student_list");
        }

        return $this->render('admin/edit_student.html.twig', ['form'=>$form]);
    }

    #[Route('/admin/courses', name: 'app_admin_course_list')]
    public function listCourses(EntityManagerInterface $em): Response
    {
        $courses = $em->getRepository(Course::class)->findAll();

        return $this->render('admin/show_courses.html.twig', [
            'courses' => $courses
        ]);
    }
}