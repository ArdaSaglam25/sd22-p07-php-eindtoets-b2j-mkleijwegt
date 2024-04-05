<?php

namespace App\Controller;

use App\Entity\SchoolGroup;
use App\Entity\Student;
use App\Form\StudentType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SchoolGroupController extends AbstractController
{
    #[Route('/', name: 'app_school_group')]
    public function index(): Response
    {
        return $this->render('school_group/index.html.twig');
    }

    #[Route('/school_group', name: 'app_school_group_show')]
    public function show(EntityManagerInterface $entityManager): Response
    {
        $schoolGroups = $entityManager->getRepository(SchoolGroup::class)->findAll();

        return $this->render('school_group/show.html.twig', [
            'school_groups' => $schoolGroups
        ]);
    }


    #[Route('/school_class/{id}', name: 'app_show_class')]
    public function showClass(EntityManagerInterface $entityManager, int $id): Response
    {
        $schoolGroups = $entityManager->getRepository(SchoolGroup::class)->find($id);

        return $this->render('school_group/showclass.html.twig', [
            'school_students' => $schoolGroups
        ]);
    }

    #[Route('/school_student/{id}', name: 'app_show_student')]
    public function showstudent(EntityManagerInterface $entityManager, int $id): Response
    {
        $student = $entityManager->getRepository(Student::class)->find($id);

        return $this->render('school_group/student.html.twig', [
            'school_student' => $student
        ]);
    }

    #[Route('/student_form/{id}', name: 'student_form')]
    public function Form(EntityManagerInterface $entityManager, Request $request, int $id): Response
    {
        $schoolgroup = $entityManager->getRepository(SchoolGroup::class)->find($id);

        $form = $this->createForm(StudentType::class);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $student = $form->getData();
            $student->setSchoolgroup($schoolgroup);
            $entityManager->persist($student);
            $entityManager->flush();
            $this->addFlash('success', 'student is toegevoed!');

            // ... perform some action, such as saving the task to the database

            return $this->redirectToRoute('app_show_class',['id' => $schoolgroup->getId()]);
        }

        return $this->render('school_group/student_form.html.twig', [
            'form' => $form,
            'klas' => $schoolgroup
        ]);
    }
    #[Route('/delete-student/{id}', name: 'delete_student')]
    public function deleteStudent(EntityManagerInterface $entityManager, int $id): Response
    {
        $student = $entityManager->getRepository(Student::class)->find($id);
        $entityManager->remove($student);
        $entityManager->flush();
        $this->addFlash('danger', 'student is verwijderd!');

        return $this->redirectToRoute('app_show_class',['id' => $student->getSchoolgroup()->getId()]);

    }
}
