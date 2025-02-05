import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

interface Question {
  operand1: number;
  operand2: number;
  userAnswer?: number;
  correctAnswer: number;
}

@Component({
  selector: 'app-quizz',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './quizz.component.html',
  styleUrls: ['./quizz.component.scss']
})
export class QuizzComponent implements OnInit {

  questions: Question[] = [];
  numberOfQuestions = 5;
  score: number | null = null;

  ngOnInit(): void {
    this.generateQuestions(this.numberOfQuestions);
  }

  generateQuestions(count: number): void {
    this.questions = [];
    for (let i = 0; i < count; i++) {
      const a = this.getRandomInt(1, 10);
      const b = this.getRandomInt(1, 10);
      this.questions.push({
        operand1: a,
        operand2: b,
        correctAnswer: a + b
      });
    }
  }

  getRandomInt(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  submitQuiz(): void {
    let totalCorrect = 0;
    this.questions.forEach(q => {
      if (q.userAnswer === q.correctAnswer) {
        totalCorrect++;
      }
    });
    this.score = totalCorrect;
  }

  resetQuiz(): void {
    this.score = null;
    this.generateQuestions(this.numberOfQuestions);
  }
}
