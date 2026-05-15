package org.example.model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Objects;

public class Session
{
    private int id;
    private int cinemaId;
    private String movieName;
    private LocalDate sessionDate;
    private LocalTime sessionTime;
    private int hallNumber;

    private String cinemaName;

    public Session() {}

    public Session(int id, int cinemaId, String movieName, LocalDate sessionDate, LocalTime sessionTime, int hallNumber)
    {
        this.id = id;
        this.cinemaId = cinemaId;
        this.movieName = movieName;
        this.sessionDate = sessionDate;
        this.sessionTime = sessionTime;
        this.hallNumber = hallNumber;
    }

    public int getId() { return id; }
    public int getCinemaId() { return cinemaId; }
    public String getMovieName() { return movieName; }
    public LocalDate getSessionDate() { return sessionDate; }
    public LocalTime getSessionTime() { return sessionTime; }
    public int getHallNumber() { return hallNumber; }
    public String getCinemaName() { return cinemaName; }

    public void setId(int id) { this.id = id; }
    public void setCinemaId(int cinemaId) { this.cinemaId = cinemaId; }
    public void setMovieName(String movieName) { this.movieName = movieName; }
    public void setSessionDate(LocalDate d) { this.sessionDate = d; }
    public void setSessionTime(LocalTime t) { this.sessionTime = t; }
    public void setHallNumber(int hallNumber) { this.hallNumber = hallNumber; }
    public void setCinemaName(String cinemaName) { this.cinemaName = cinemaName; }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Session s = (Session) o;
        return id == s.id && cinemaId == s.cinemaId && hallNumber == s.hallNumber
                && Objects.equals(movieName, s.movieName)
                && Objects.equals(sessionDate, s.sessionDate)
                && Objects.equals(sessionTime, s.sessionTime);
    }
    @Override public int hashCode()
    {
        return Objects.hash(id, cinemaId, movieName, sessionDate, sessionTime, hallNumber);
    }
    @Override public String toString()
    {
        return "Session{id=" + id + ", movie='" + movieName
                + "', date=" + sessionDate + ", time=" + sessionTime + "}";
    }
}