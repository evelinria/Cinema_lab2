package org.example.model;

import java.util.Objects;

public class Cinema {
    private int id;
    private String name;
    private String address;
    private int halls;

    public Cinema() {}

    public Cinema(int id, String name, String address, int halls) {
        this.id      = id;
        this.name    = name;
        this.address = address;
        this.halls   = halls;
    }

    public int    getId()      { return id; }
    public String getName()    { return name; }
    public String getAddress() { return address; }
    public int    getHalls()   { return halls; }

    public void setId(int id)           { this.id      = id; }
    public void setName(String name)    { this.name    = name; }
    public void setAddress(String a)    { this.address = a; }
    public void setHalls(int halls)     { this.halls   = halls; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Cinema c = (Cinema) o;
        return id == c.id && halls == c.halls
                && Objects.equals(name, c.name)
                && Objects.equals(address, c.address);
    }

    @Override public int hashCode() { return Objects.hash(id, name, address, halls); }
    @Override public String toString() { return "Cinema{id=" + id + ", name='" + name + "'}"; }
}
