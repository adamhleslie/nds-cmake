#include "Example.hpp"

Example::Example(const int& val)
    : m_val(val)
{}

const int& Example::val() const
{
	return m_val;
}

void Example::val(const int& val)
{
	m_val = val;
}
